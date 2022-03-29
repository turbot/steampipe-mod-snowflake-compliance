## Data Encryption

All data stored in Snowflake is transparently encrypted using a key hierarchy (with cloud HSM backed root of trust), which provides enhanced security by encrypting individual pieces of data using a different key. Snowflake also offers the use of a customer-managed key (CMK) in this encryption process through a feature called Tri-Secret Secure. Independent of the Tri-secret secure feature, Snowflake rotates the keys every 30 days, ensuring that new data ingested after 30 days is encrypted using a new key hierarchy.

The data encryption best practices are as follows:

- Use Tri-Secret secure and review AWS Tri-Secret Secure and Azure Tri-Secret Secure FAQs.

- Use automatic key rotation for the CMK as provided by the cloud provider (such as AWS KMS). If, for any reason, you need to manually change your CMK, then contact Snowflake support for assistance.

- Remember to enable Tri-Secret Secure in the target account when using the Replication feature to replicate a database to another account.

- Enable periodic rekeying in Snowflake if your organization requires rekeying of data at regular intervals

- If you want to encrypt/decrypt certain columns in addition to the transparent encryption provided by Snowflake, then use the built-in encryption functions.
