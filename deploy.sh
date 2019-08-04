docker build -t r3r00t3d/multi-client:latest -t r3r00t3d/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t r3r00t3d/multi-server:latest -t r3r00t3d/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t r3r00t3d/multi-worker:latest -t r3r00t3d/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push r3r00t3d/multi-client:latest
docker push r3r00t3d/multi-server:latest
docker push r3r00t3d/multi-worker:latest

docker push r3r00t3d/multi-client:$SHA
docker push r3r00t3d/multi-server:$SHA
docker push r3r00t3d/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=r3r00t3d/multi-server:$SHA
kubectl set image deployments/client-deployment client=r3r00t3d/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=r3r00t3d/multi-worker:$SHA

