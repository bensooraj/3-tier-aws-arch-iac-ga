from diagrams import Diagram, Cluster, Edge
from diagrams.aws.storage import S3

with Diagram("3tier architecture", show=False):
    with Cluster("AWS"):
        S3("""S3: terraform backend""")
