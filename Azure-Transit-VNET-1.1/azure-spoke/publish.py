#!/usr/bin/python

import json
import subprocess
import shlex
import time
import logging
import sys
from applicationinsights import TelemetryClient


LOG_FILENAME1 = 'azure-autoscaling-publish.log'
logging.basicConfig(filename=LOG_FILENAME1,level=logging.INFO, filemode='w',format='[%(asctime)s] [%(levelname)s] (%(threadName)-10s) %(message)s',)
logger1 = logging.getLogger(__name__)
logger1.setLevel(logging.INFO)

metric_list = [ "panSessionActive",\
                "DataPlaneCPUUtilizationPct",\
                "panGPGatewayUtilizationPct",\
                "panGPGWUtilizationActiveTunnels",\
                "DataPlanePacketBufferUtilization",\
                "panSessionSslProxyUtilization",\
                "panSessionUtilization"]
def main():
        inst_key = sys.argv[1].strip()
        tc = TelemetryClient(inst_key)

        logger1.info("[INFO]: Instrumentation key used {}".format(inst_key))

        for metric in metric_list:
            logger1.info("[INFO]: Publishing metrics {}".format(metric))
            tc.track_metric(metric, 0)
            tc.flush()
            time.sleep(30)


if __name__ == "__main__":
    main()
