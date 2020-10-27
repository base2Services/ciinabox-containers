FROM alpine:3.9

ENV KUBECTL_VERSION="1.18.8"
ENV HELM_VERSION="2.16.12"
ENV IAM_AUTHENTICATOR_VERSION="1.18.8"
ENV EKSCTL_VERSION="0.30.0"

RUN apk add --no-cache curl ca-certificates bash groff less python py-pip \
    && pip install awscli

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q https://amazon-eks.s3-us-west-2.amazonaws.com/${IAM_AUTHENTICATOR_VERSION}/2020-09-18/bin/linux/amd64/aws-iam-authenticator -O /usr/local/bin/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator \
    && wget -q https://github.com/weaveworks/eksctl/releases/download/${EKSCTL_VERSION}/eksctl_Linux_amd64.tar.gz -O - | tar -xzO eksctl > /usr/local/bin/eksctl \
    && chmod +x /usr/local/bin/eksctl

RUN addgroup -S -g 1000 jenkins && \
    adduser -D -u 1000 jenkins -G jenkins

CMD ['kubectl']
