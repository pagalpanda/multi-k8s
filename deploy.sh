docker build -t amitpanda123/multi-client:latest -t amitpanda123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amitpanda123/multi-server:latest -t amitpanda123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amitpanda123/multi-worker:latest -t amitpanda123/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push amitpanda123/multi-client:latest
docker push amitpanda123/multi-server:latest
docker push amitpanda123/multi-worker:latest
docker push amitpanda123/multi-client:$SHA
docker push amitpanda123/multi-server:$SHA
docker push amitpanda123/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amitpanda123/multi-server:$SHA
kubectl set image deployments/client-deployment client=amitpanda123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amitpanda123/multi-worker:$SHA
