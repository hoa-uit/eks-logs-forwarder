# deploy Grafana
docker run -d --name=grafana \
  -p 3000:3000 \
  -v $(pwd)/grafana.ini:/etc/grafana/grafana.ini \
  grafana/grafana:latest


# start loki
# docker run -d --name=loki -p 3100:3100 \
#   -v $(pwd)/loki/index:/loki/index \
#   -v $(pwd)/loki/chunks:/loki/chunks \
#   -v $(pwd)/loki-config.yaml:/etc/loki/local-config.yaml \
#   grafana/loki:2.4.1 -config.file=/etc/loki/local-config.yaml

# deploy promtail
# docker run -d --name=promtail -v /var/log:/var/log -v $(pwd)/promtail-config.yaml:/etc/promtail/config.yml grafana/promtail:2.4.1 -config.file=/etc/promtail/config.yml


# ln -s $(pwd)/service.log /tmp/service.log

# sudo mv /var/log/service.log /Users/nguyenhoa/Documents/workspace/my-projects/eks-logs-forwarder/log/service.log

docker run --name loki -d -v $(pwd):/mnt/config -p 3100:3100 grafana/loki:3.0.0 -config.file=/mnt/config/loki-config.yaml
docker run --name promtail -d -v $(pwd):/mnt/config -d -v $(pwd)/log:/var/log --link loki grafana/promtail:3.0.0 -config.file=/mnt/config/promtail-config.yaml
