sudo docker run -d --cap-add NET_ADMIN -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=debug netem\
	--tc-image ghcr.io/alexei-led/pumba-debian-nettools:latest \
	--duration 5m \
	delay  --time 10000 \
	network_bft_orderer.example.com_1

sudo docker run -d --cap-add NET_ADMIN -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=debug netem\
    --tc-image ghcr.io/alexei-led/pumba-debian-nettools:latest \
    --duration 5m \
    delay  --time 10000 \
    network_bft_orderer2.example.com_1

sudo docker run -d --cap-add NET_ADMIN -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=debug netem\
    --tc-image ghcr.io/alexei-led/pumba-debian-nettools:latest \
    --duration 5m \
    delay  --time 10000 \
    network_bft_orderer3.example.com_1

sudo docker run -d --cap-add NET_ADMIN -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=debug netem\
    --tc-image ghcr.io/alexei-led/pumba-debian-nettools:latest \
    --duration 5m \
    delay  --time 10000 \
    network_bft_orderer4.example.com_1

sudo docker run -d --cap-add NET_ADMIN -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=debug netem\
    --tc-image ghcr.io/alexei-led/pumba-debian-nettools:latest \
    --duration 5m \
    delay  --time 10000 \
    network_bft_orderer5.example.com_1
