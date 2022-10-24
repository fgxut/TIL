# Reference: 
#  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
#  https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html

resource "aws_cloudfront_distribution" "example" {
  enabled             = true # Required
  comment             = ""
  aliases             = ""
  price_class         = "PriceClass_200"
  http_version        = "http2"
  is_ipv6_enabled     = true
  default_root_object = ""
  web_acl_id          = ""

  tags = {
    Name = ""
  }

  # Required
  origin {
    domain_name         = "" # Required
    origin_id           = "" # Required
    origin_path         = ""
    connection_attempts = 3  # Default
    connection_timeout  = 10 # Default

    # custom_header {
    #   name  = ""
    #   value = ""
    # }

    # If an S3 origin is required, use s3_origin_config instead.
    custom_origin_config {
      http_port                = 80                              # Required
      https_port               = 443                             # Required
      origin_protocol_policy   = "https-only"                    # Required
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"] # Required
      origin_read_timeout      = 30                              # Default
      origin_keepalive_timeout = 5                               # Default
    }
    # s3_origin_config {
    #   origin_access_identity = ""
    # }
  }

  # Required
  default_cache_behavior {
    target_origin_id = ""                                                           # Required
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"] # Required
    cached_methods   = ["GET", "HEAD"]                                              # Required
    # Reference: https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
    # cache_policy_id  = ""

    # If a cache policy is required, use cache_policy_id instead.
    forwarded_values {
      # headers      = []
      query_string = false

      cookies {
        forward = "none" # Required
      }
    }

    # Reference: https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/Expiration.html
    min_ttl                = 0        # Default
    default_ttl            = 86400    # Default
    max_ttl                = 31536000 # Default
    compress               = true
    viewer_protocol_policy = "redirect-to-https" # Required
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = ""                                                           # Required
    target_origin_id = ""                                                           # Required
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"] # Required
    cached_methods   = ["GET", "HEAD"]                                              # Required
    # Reference: https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
    # cache_policy_id  = ""

    # If a cache policy is required, use cache_policy_id instead.
    forwarded_values {
      # headers      = []
      query_string = false

      cookies {
        forward = "none" # Required
      }
    }

    # Reference: https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/Expiration.html
    min_ttl                = 0        # Default
    default_ttl            = 86400    # Default
    max_ttl                = 31536000 # Default
    compress               = true
    viewer_protocol_policy = "redirect-to-https" # Required
  }

  # # Cache behavior with precedence 1
  # ordered_cache_behavior {
  #   path_pattern     = ""                                                           # Required
  #   target_origin_id = ""                                                           # Required
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"] # Required
  #   cached_methods   = ["GET", "HEAD"]                                              # Required
  #   # 参考: https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
  #   # cache_policy_id  = ""

  #   # If a cache policy is required, use cache_policy_id instead.
  #   forwarded_values {
  #     # headers      = []
  #     query_string = false

  #     cookies {
  #       forward = "none" # Required
  #     }
  #   }

  #   # Reference: https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/Expiration.html
  #   min_ttl                = 0
  #   default_ttl            = 0
  #   max_ttl                = 300
  #   compress               = true
  #   viewer_protocol_policy = "redirect-to-https" # Required
  # }

  logging_config {
    bucket          = ""
    prefix          = ""
    include_cookies = false
  }

  # Required
  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = ""
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2"
  }

  # Required
  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }
}

# If an S3 origin is required, uncomment.
# resource "aws_cloudfront_origin_access_identity" "example" {
#   comment = ""
# }
