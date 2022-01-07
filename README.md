# k8s-debug

Image is based on ubuntu:20.04 
(Yeah, I know it's size isn't very small but will useful for most sysadmins)

## Debug node level 
```bash
kubectl debug node/<node-name> -it --image=waiyanwinhtain/k8s-debug:latest
```

## Debug pod level
```bash
kubectl debug mypod  -it --image=waiyanwinhtain/k8s-debug:latest
```
