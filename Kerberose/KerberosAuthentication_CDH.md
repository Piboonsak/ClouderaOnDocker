# Enabling Kerberos Authentication for CDH

## Required

1.Required Role: Cluster Administrator or Full Administrator
2.Kerberos must already be deployed in your organization and the Kerberos key distribution center (KDC) .For Hue and Oozie, the Kerberos realm must support renewable tickets.
Link to :[Kerberos Security Artifacts](https://www.cloudera.com/documentation/enterprise/5-15-x/topics/cm_sg_principal_keytab.html).
3.Important: Before integrating Kerberos with your cluster, configure TLS/SSL encryption between Cloudera Manager Server and all Cloudera Manager Agent host systems in the cluster.
[Link to configure TLS/SSL encryption : ](https://www.cloudera.com/documentation/enterprise/5-15-x/topics/how_to_configure_cm_tls.html#concept_wk4_jlx_qw)


ref : https://www.cloudera.com/documentation/enterprise/5-15-x/topics/cm_sg_authentication.html
ref : https://www.cloudera.com/documentation/enterprise/5-15-x/topics/cm_sg_intro_kerb.html#xd_583c10bfdbd326ba--6eed2fb8-14349d04bee--76dd
ref : [Enabling Kerberos Using the Wizard
](https://www.cloudera.com/documentation/enterprise/5-15-x/topics/cm_sg_s4_kerb_wizard.html#concept_ssg_x5y_l4)


# Enable Kerberos for Cluster 1
**Getting Started**

[]! Set up a working KDC. Cloudera Manager supports MIT KDC and Active Directory.


[]! The KDC should be configured to have non-zero ticket lifetime and renewal lifetime. CDH will not work properly if tickets are not renewable.


[]! OpenLdap client libraries should be installed on the Cloudera Manager Server host if you want to use Active Directory. Also, Kerberos client libraries should be installed on ALL hosts.


[]! Cloudera Manager needs an account that has permissions to create other accounts in the KDC.




















































