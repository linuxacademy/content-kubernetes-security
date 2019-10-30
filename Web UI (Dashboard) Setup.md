### Kubernetes Security
### Dashboard Setup Command Summary

The following is a command summary to install the Kubernetes Dashboard on your playground server.

1) Install the Web UI Dashboard using the recommended yaml file provided by Kubernetes:

``` $kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml```

2) Use the commands below to download the yaml file to create a service account. Then use cat to look at the file contents, and finally execute the file with the kubectl command.

```
$ wget https://raw.githubusercontent.com/linuxacademy/content-kubernetes-security/master/create-admin-sa-dashboard.yaml
$ cat create-admin-sa-dashboard.yaml 
$ kubectl apply -f create-admin-sa-dashboard.yaml
```

For your reference here, this is the contents of the file.
```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
```

3) After creating the service account, it is necessary to create the cluster role binding. To do so you may foenload the file, examine its contents, and run it as before with the service account yaml.

```
$ wget https://raw.githubusercontent.com/linuxacademy/content-kubernetes-security/master/create-admin-rb-dashboard.yaml
$ cat create-admin-rb-dashboard.yaml
$ kubectl apply -f create-admin-rb-dashboard.yam
```

For your refence, the yaml is as follows:

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
```

4) After creating the service account and cluster role binding, you may use the following command to query the secret for the admin-user. The reason we do this is to obtain the token that has been created for that user. We will use the token to login to the dashboard.

```$ kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')```

The command will provide output similar to the following:

```
Name:         admin-user-token-ff2mm
Namespace:    kubernetes-dashboard
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: admin-user
              kubernetes.io/service-account.uid: c6facdce-2578-11e9-8dc9-062d4745d730

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1025 bytes
namespace:  11 bytes
token:      <your token data here>
```

The token data displayed should be copied off to a document or notepad so that you may use it when it is time to log into the dashboard.

5) The port specified in the dashboard sets it up to listen on localhost:8001. To expose this port to a client you will need to run the Kubernetes proxy, and tunnel into the server with ssh.

To run the proxy, input the following command. You may elect to place an '&' ampersand after the command to run it in background. If you do so, not the PID (Process ID) so you may terminate it later.

```
$ kubectl proxy
```

In a terminal emulator window, you may start the tunnel with the following command. Again an '&' ampersand may be used to run it in background.

```
$ ssh -g -L 8001:localhost:8001 -f -N cloud_user@<Your server IP address here>
```

Once the tunnel has been established, you may enter the following URL address from the same system that is running the ssh tunnel.

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/.

For more information, the following tutorial is available:
https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

Information on creating the service account and cluster role binding may be found here:
https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
