env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, "postgres://lurukbtubkrzhe:UQSGG7BN7Bf1TRNk2yT2Iiy03R@ec2-107-20-245-187.compute-1.amazonaws.com:5432/db41gpgnabtolc")


# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!