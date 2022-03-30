## Data Encryption

All data stored in Snowflake is transparently encrypted using a key hierarchy (with cloud HSM backed root of trust), which provides enhanced security by encrypting individual pieces of data using a different key. Snowflake also offers the use of a customer-managed key (CMK) in this encryption process through a feature called Tri-Secret Secure. Independent of the Tri-secret secure feature, Snowflake rotates the keys every 30 days, ensuring that new data ingested after 30 days is encrypted using a new key hierarchy.
