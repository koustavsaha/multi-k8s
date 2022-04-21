docker build -t koustavs18/multi-client:latest -t koustavs18/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t koustavs18/multi-server:latest -t koustavs18/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t koustavs18/multi-worker:latest -t koustavs18/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push koustavs18/multi-client:latest
docker push koustavs18/multi-server:latest
docker push koustavs18/multi-worker:latest

docker push koustavs18/multi-client:$SHA
docker push koustavs18/multi-server:$SHA
docker push koustavs18/multi-worker:$SHA

kubectl apply -f k8s 

kubectl set image deployments/server-deployment server=koustavs18/multi-server:$SHA 
kubectl set image deployments/client-deployment client=koustavs18/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=koustavs18/multi-worker:$SHA 