
resource "aws_ssm_document" "foo" {
  name          = "test_document"
  document_type = "Command"

  content = "${file("${path.module}/../ssm-tools/ssmDocs/manageClario.yml")}"
}