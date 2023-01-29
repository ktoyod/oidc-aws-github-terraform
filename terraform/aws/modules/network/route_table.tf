resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "terraform-template-public"
  }
}

# Do not create a private route table
# because we will not create a NAT gateway.
# resource "aws_route_table" "private" {
# vpc_id = aws_vpc.main.id
#
# route {
# cidr_block     = "0.0.0.0/0"
# nat_gateway_id = aws_nat_gateway.main.id
# }
#
# tags = {
# Name = "terraform-template-private"
# }
# }

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
