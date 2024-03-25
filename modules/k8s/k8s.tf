provider "helm" {
  kubernetes {
    host                   = var.host
    client_certificate     = var.client_certificate
    client_key             = var.client_key
    cluster_ca_certificate = var.cluster_ca_certificate
  }
}
resource "helm_repository" "jetstack" {
  name = "jetstack"
  url  = "https://charts.jetstack.io"
}

resource "helm_release" "cert_manager" {
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.14.0"
  name             = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_repository" "actions_runner_controller" {
  name = "actions-runner-controller"
  url  = "https://actions-runner-controller.github.io/actions-runner-controller"
}

resource "helm_release" "actions_runner_controller" {
  name             = "actions-runner-controller"
  repository       = helm_repository.actions_runner_controller.metadata[0].name
  chart            = "actions-runner-controller"
  namespace        = "actions-runner-system"
  create_namespace = true
  wait             = true

  set {
    name  = "authSecret.create"
    value = "true"
  }

  set {
    name  = "authSecret.github_token"
    value = var.github_token
  }
}

resource "kubernetes_namespace" "self_hosted_runners" {
  metadata {
    name = "self-hosted-runners"
  }
}

resource "kubernetes_manifest" "dos_box_runner" {
  manifest = jsonencode({
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "RunnerDeployment"
    metadata = {
      name      = "dos-box-runner"
      namespace = kubernetes_namespace.self_hosted_runners.metadata[0].name
    }
    spec = {
      replicas = 1
      template = {
        spec = {
          ephemeral  = true
          repository = "tmtam612/cloud-mastery-iac"
          tolerations = [
            {
              key      = "virtual-kubelet.io/provider"
              operator = "Exists"
              effect   = "NoSchedule"
            }
          ]
        }
      }
    }
  })
}

resource "kubernetes_manifest" "dos_box_runner_autoscaler" {
  manifest = jsonencode({
    apiVersion = "actions.summerwind.dev/v1alpha1"
    kind       = "HorizontalRunnerAutoscaler"
    metadata = {
      name      = "dos-box-runner-autoscaler"
      namespace = kubernetes_namespace.self_hosted_runners.metadata[0].name
    }
    spec = {
      scaleTargetRef = {
        kind = "RunnerDeployment"
        name = kubernetes_manifest.dos_box_runner.metadata[0].name
      }
      minReplicas = 1
      maxReplicas = 5
      metrics = [
        {
          type               = "TotalNumberOfQueuedAndInProgressWorkflowRuns"
          scaleUpThreshold   = "1"
          scaleDownThreshold = "0"
          scaleUpFactor      = "2"
          scaleDownFactor    = "0.5"
        }
      ]
    }
  })
}
