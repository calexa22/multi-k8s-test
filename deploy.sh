docker build -t calexa22/multi-docker-test-client-k8s:latest -t calexa22/multi-docker-test-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t calexa22/multi-docker-test-server:latest -t calexa22/multi-docker-test-server:$SHA -f ./server/Dockerfile ./server
docker build -t calexa22/multi-docker-test-worker:latest -t calexa22/multi-docker-test-worker:$SHA -f ./worker/Dockerfile ./worker

docker push calexa22/multi-docker-test-client-k8s:latest
docker push calexa22/multi-docker-test-server:latest
docker push calexa22/multi-docker-test-worker:latest
docker push calexa22/multi-docker-test-client-k8s:$SHA
docker push calexa22/multi-docker-test-server:$SHA
docker push calexa22/multi-docker-test-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=calexa22/multi-docker-test-client-k8s:$SHA
kubectl set image deployments/server-deployment server=calexa22/multi-docker-test-server:$SHA
kubectl set image deployments/worker-deployment worker=calexa22/multi-docker-test-worker:$SHA
