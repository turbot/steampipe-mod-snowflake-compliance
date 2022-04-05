## Description

Snowflake supports multi-factor authentication (MFA) to provide increased login security for users connecting to Snowflake. MFA support is provided as an integrated Snowflake feature, powered by the [Duo Security](http://www.duosecurity.com/) service, which is managed completely by Snowflake.

Users do not need to separately sign up with Duo or perform any tasks, other than installing the Duo Mobile application, which is supported on multiple smart phone platforms (iOS, Android, Windows, etc.). See the [Duo User Guide](http://guide.duosecurity.com/) for more information about supported platforms/devices and how Duo multi-factor authentication works.

MFA is enabled on a per-user basis; however, at this time, users are not automatically enrolled in MFA. To use MFA, users must enroll themselves.

At a minimum, Snowflake strongly recommends that all users with the `ACCOUNTADMIN` role be required to use MFA.
