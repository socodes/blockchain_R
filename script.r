# import digest library to hash the value as sha256
library("digest")

#import library to use in testing.
library(testthat)

# to use sample digest function, you can run this line:
# digest("this is an example string" ,"sha256")

# Before you start building your blockchain, 
# you need to start the chain somewhere. This is done 
# using a so-called Genesis Block. It contains no data and 
# arbitrary values for proof and previous hash (as there is no previous block).

# Define Genesis Block (index 1 and arbitrary previous hash)
# in other words, first block(dummy node).
block_genesis <-  list(index = 1,
                       timestamp = Sys.time(),
                       data = "Genesis Block",
                       previous_hash = "0",
                       proof = 1)

#Function that creates a hashed "block"
hash_block <- function(block){
  block$new_hash <- digest(c(block$index,
                             block$timestamp,
                             block$data,
                             block$previous_hash), "sha256")
  return(block)
}

### Simple Proof of Work Algorithm
proof_of_work <- function(last_proof){
  proof <- last_proof + 1
  
  # Increment the proof number until a number is found that is divisable by 99 and by the proof of the previous block
  while (!(proof %% 99 == 0 & proof %% last_proof == 0 )){
    proof <- proof + 1
  }
  
  return(proof)
}

#A function that takes the previous block and normally some data
# (in our case the data is a string indicating which block in the chain it is)
gen_new_block <- function(previous_block){
  
  #Proof-of-Work
  new_proof <- proof_of_work(previous_block$proof)
  
  #Create new Block
  new_block <- list(index = previous_block$index + 1,
                    timestamp = Sys.time(),
                    data = paste0("this is block ", previous_block$index +1),
                    previous_hash = previous_block$new_hash,
                    proof = new_proof)
  
  #Hash the new Block
  new_block_hashed <- hash_block(new_block)
  
  return(new_block_hashed)
}

# create a list named blockchain whose first node is block_genesis
blockchain <- list(block_genesis)
previous_block <- blockchain[[1]]

# How many blocks should we add to the chain after the genesis block
num_of_blocks_to_add <- 5

# Add blocks to the chain with generated data.
for (i in 1: num_of_blocks_to_add){
  block_to_add <- gen_new_block(previous_block) 
  blockchain[i+1] <- list(block_to_add)
  previous_block <- block_to_add
  
  print(cat(paste0("Block ", block_to_add$index, " has been added", "\n",
                   "\t", "Proof: ", block_to_add$proof, "\n",
                   "\t", "Hash: ", block_to_add$new_hash)))
}

blockchain[[5]]
# 5th block's index should be 5
expect_true(blockchain[[5]]$index == 5)
# 3rd blocks data should be "this is block 3"
expect_true(blockchain[[3]]$data == "this is block 3")
#5th blocks previous hash value should be equal to 4th blocks current hash.
expect_true(blockchain[[5]]$previous_hash == blockchain[[4]]$new_hash)

# Clear environment
rm(list = ls()) 

# Clear console
cat("\014")  # ctrl+L
