# Define an AWS IAM role specified for the EC2 instances
####################################################

data "aws_iam_policy_document" "ec2_role_policy" {

  version = var.iam_role_policy_version

  statement {
    
    effect = var.iam_role_policy_effect
    actions = [
      var.iam_role_policy_action,
    ]

    principals {
      type = var.iam_role_policy_principal_type
      identifiers = [
        var.iam_role_policy_principal_identifier
      ]
    }

    sid   = ""
  }

}

resource "aws_iam_role" "ec2_full_access_role" {
  name = var.iam_role_name

  assume_role_policy = data.aws_iam_policy_document.ec2_role_policy.json

  tags = {
    name = var.iam_role_name
  }
}

resource "aws_iam_policy" "ec2_policy" {

  name        = "cm_ec2_policy"
  description = "IAM policy for accessing EC2"
  policy      = data.aws_iam_policy_document.ec2_full_access_policy.json
}

data "aws_iam_policy_document" "ec2_full_access_policy" {

  version = var.iam_role_policy_version

  statement {
    actions = [
      var.iam_policy_action,
    ]

    effect = var.iam_policy_effect

    resources = ["*"]
  }
}

resource "aws_iam_policy_attachment" "iam_policy_attach" {
  name = "iam_policy_attachment"
  roles = [
    "${aws_iam_role.ec2_full_access_role.name}"
  ]
  policy_arn = "${aws_iam_policy.ec2_policy.arn}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.iam_instance_profile
  role = "${aws_iam_role.ec2_full_access_role.name}"
}

