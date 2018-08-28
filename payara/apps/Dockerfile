FROM eurasia36/payara-base:latest
MAINTAINER "Vadim Isaev" <vadim.o.isaev@gmail.com>

# esbd
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/esbd/esbd-dao-app/2.2.6/esbd-dao-app-2.2.6.ear $AUTODEPLOY_DIR

# epayment
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-dao-app/1.2.4/epayment-dao-app-1.2.4.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-facade-app/1.2.6/epayment-facade-app-1.2.6.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-notification-daemon-app/2.1/epayment-notification-daemon-app-2.1.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-ws-app/1.2.3/epayment-ws-app-1.2.3.ear $AUTODEPLOY_DIR

# insurance
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-calculation-app/2.3.2/insurance-calculation-app-2.3.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-dao-app/1.3.2/insurance-dao-app-1.3.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-facade-app/1.4.2/insurance-facade-app-1.4.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-daemon-app/1.3.2/insurance-daemon-app-1.3.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-notification-daemon-app/2.2.2/insurance-notification-daemon-app-2.2.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-ws-app/1.3.2/insurance-ws-app-1.3.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-crm-app/3.3.3/insurance-crm-app-3.3.3.ear $AUTODEPLOY_DIR

# eurasia36
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/eurasia36/eurasia36-notification-templates-app/1.1/eurasia36-notification-templates-app-1.1.ear $AUTODEPLOY_DIR
