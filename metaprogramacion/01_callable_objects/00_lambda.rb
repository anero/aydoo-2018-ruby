lambda_1 = lambda { |a, b| puts a + b }

lambda_1.call(2, 3) # => 5

lambda_2 = ->(a, b) { puts a - b }

lambda_2.call(2, 3) # => -1
