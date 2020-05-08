docker build -t multi-client:latest -t multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t multi-server:latest -t multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t multi-worker:latest -t multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push multi-client:latest
docker push multi-server:latest
docker push multi-worker:latest

docker push multi-client:$SHA
docker push multi-server:$SHA
docker push multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=multi-server:$SHA
kubectl set image deployments/client-deployment client=multi-client:$SHA
kubectl set image deployments/worker-deployment worker=multi-worker:$SHA
