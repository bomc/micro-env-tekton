# Setup for using tekton with argocd

A private Git repository on GitHub can be accessed using either SSH or HTTPS. The preferred method is to always use SSH and a SSH key pair. Only use HTTPS if you have no choice.
## Access private repository on GitHub

```
$ ssh-keygen -t rsa -b 4096 -C "tekton@tekton.dev" -f tekton-ssh-key -N tekton
Generating public/private rsa key pair.
Your identification has been saved in tekton-ssh-key
Your public key has been saved in tekton-ssh-keym.pub
The key fingerprint is:
SHA256:VxENc52OCS9L+R+gIQ1rQBRSL5P4da3+OiZNPlCft8Q tekton@tekton.dev
The key's randomart image is:
+---[RSA 4096]----+
|     .+=.   =+...|
|      o.o. ..+...|
|     . +.o+.=.+  |
|      . ++.O.= . |
|       .S =.B +  |
|         o.+ + E |
|          =.  + o|
|         . *.  o |
|          o.+.   |
+----[SHA256]-----+
```

This generates two files `tekton-ssh-key` and `tekton-ssh-key.pub` with passphrase behind the parameter `-n`

To register the repository SSH key with your private repository on GitHub, go to the Settings for the repository.

On GitHub the repository SSH key is referred to by the term Deploy key. Search down the settings page and find the Deploy keys section and select it.

Click on the Add deploy key button. In this section, give the key a name and paste in the contents of the public key file from the SSH key pair. This is the file with the .pub extension, which in this example is called tekton-ssh-key.pub.

The next step is to create a secret in Minikube to hold the private key of the SSH key pair. 
Create the secret run:

```
cat > tekton-git-ssh-secret.yaml << EOM
apiVersion: v1
kind: Secret
metadata:
  name: git-ssh-key
  namespace: tekton-pipelines
  annotations:
    tekton.dev/git-0: github.com
type: kubernetes.io/ssh-auth
data:
  ssh-privatekey: ${ENV_PRIV_KEY}
---
EOM
```
Where `ENV_PRIV_KEY` is the private key. The seceret lives in the `tekton-pipelines` namespace.

Or run the bash file `create-tekton-secret-yaml.sh` that do the stuff in one step.

### Register the public key from `tekton-ssh-key.pub` in github.com.

Go to the github website and select the repository to access. 
From the menu bar, select `Settings` and then `Deploy keys` in the middle. 
Insert the content from the public key `tekton-ssh-key.pub` to the field and set `Allow write access`.
