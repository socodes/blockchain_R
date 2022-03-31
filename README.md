# 
# Blockchain in R

A blockchain is a chain(list) of related blocks. 

### The structure of block:
![](https://miro.medium.com/max/1364/1*l3q104r2txeX7fC7dLOQUQ.png)

A block consist of a list of transaction(in this program a string is used to simplify),
a hash of the previous block in the chain, and a certain nonce value 
which the miner should receive in such a way as to prove that the work spent
block mining has been completed.

Like Bitcoin, cryptographic algorithm SHA-256 is used for hash calculating.
R library "digest" is used to generate hashed SHA-256 version of a string.

Dependencies:
- R version 4.0.5 or newer
- digest
- testthat

Building:
- will be implemented.

Testing:
Unit testing is used. Testing covers index of a block, data of a block and privous hash and current hash checking.

````
- Change current working directory to repository location.
- Run the script: "Rscript tests.R"
````
Install:
- will be updated.

How to use:
- Install required R language version from https://www.r-project.org
- install required packages from command line as:
install.package(PACKAGE_NAME)
- Change current working directory to repository location.
- Run the script: "Rscript script.R"

#### Related Readings:
``````
Nonce: https://en.bitcoin.it/wiki/Nonce
Proof of work: https://en.bitcoin.it/wiki/Proof_of_work
Cryptographic Hash Function: https://en.wikipedia.org/wiki/Cryptographic_hash_function
Mining: https://en.bitcoin.it/wiki/Mining
Difficulty: https://en.bitcoin.it/wiki/Difficulty



