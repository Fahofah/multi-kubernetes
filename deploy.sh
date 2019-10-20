docker build -t fahriulucay1/multi-client:latest -t fahriulucay1/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t fahriulucay1/multi-server:latest -t fahriulucay1/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t fahriulucay1/multi-worker:latest -t fahriulucay1/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push fahriulucay1/multi-client:latest
docker push fahriulucay1/multi-server:latest
docker push fahriulucay1/multi-worker:latest
docker push fahriulucay1/multi-client:$GIT_SHA
docker push fahriulucay1/multi-server:$GIT_SHA
docker push fahriulucay1/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=fahriulucay1/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=fahriulucay1/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=fahriulucay1/multi-worker:$GIT_SHA
