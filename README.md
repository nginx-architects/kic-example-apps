# kic-example-apps

Consolidated some examples from and added a simple app for responses.

<https://docs.nginx.com/nginx-ingress-controller/configuration/configuration-examples/>

Please feel free to add to this repo.

## Usage

The yaml files in the root of this repo can be use individual, the entire application/service and ingress definition is included in each file.

## NGINX App Protect

There is a sub-directory in this repo that contains a complete application and ingress definitions that protects it utilizing the NGINX App Protect WAF.

The sample application is "Arcadia Financial" which is a micro-service based deployment. The App Protect example contains two different policies:

1. An API Security policy that uses an open API spec that defines exactly what URI, method and request body should contain
1. A "Threat Campaign" policy that uses the F5 Labs high-accuracy (low false positive) patterns. This policy, by default, also enables the default policy which blocks all OWASP top 10 attack patterns.

The base path / is protected by the OWASP top 10 + threat campaign policy and the /trading and /api endpoints are protected by the very specific policy that is created by linking to the Arcadia OpenAPI spec file <https://app.swaggerhub.com/apis/F5EMEASSA/Arcadia-OAS3/2.0.1-schema>

There are several mappings that are required in order enable App Protect. The diagram belows is color coded to show the various mappings.

![images/app-protect-config-mapping.png](images/app-protect-config-mapping.png)

## Deployment

1. Update the hostnames in the virtualserver definition and provided tests (find/replace/sed)
1. You can deploy all files at once:

    ```shell
    kubectl apply -f .
    ```

1. Make sure everything works by running

    ```shell
    kubectl get vs vs-arcadia
    ```

    *Note the STATE should be "Valid"*

## Testing Protection/Exploits

There are several requests / attacks provided in the tests folder. Note that the OpenAPI spec defines the method for each API call. In the case of buy stocks, it is a POST.
![images/buy-stock-oapi.png](images/buy-stock-oapi.png)

1. When you run the curl command from the [test/01-post-money-transfer.sh](test/01-post-money-transfer.sh) which uses the POST method, the request completes successfully.

1. When you run the [test/01-post-money-transfer.sh](test/01-post-money-transfer.sh) which uses the GET method, the request is blocked.

1. Additional tests are provided to test some common exploits.
