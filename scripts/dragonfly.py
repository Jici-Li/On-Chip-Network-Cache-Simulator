import networkx as nx
import matplotlib.pyplot as plt
import pandas as pd
from itertools import combinations
import numpy as np

def build_dragonfly(p=4, a=4):
    G = nx.Graph()
    nodes = [(g, r) for g in range(a) for r in range(p)]
    G.add_nodes_from(nodes)
    
    for g in range(a):
        group_nodes = [(g, r) for r in range(p)]
        G.add_edges_from(combinations(group_nodes, 2), color='blue')
    
    for r in range(p):
        for g1, g2 in combinations(range(a), 2):
            if (g1 + r) % a == g2 % a:
                G.add_edge((g1, r), (g2, r), color='red')
    return G

def build_mesh(n=4):
    return nx.grid_2d_graph(n, n)

dfly = build_dragonfly()
mesh = build_mesh()

def analyze(G, name):
    return {
        'Topology': name,
        'Avg Path Length': nx.average_shortest_path_length(G),
        'Diameter': nx.diameter(G),
        'Max Degree': max(dict(G.degree).values()),
        'Edge Count': G.number_of_edges()
    }

results = pd.DataFrame([analyze(dfly, 'Dragonfly'), 
                       analyze(mesh, '4x4 Mesh')])
print(results.set_index('Topology'))

plt.figure(figsize=(12, 5))

plt.subplot(121)
pos_dfly = {(g, r): (g + 0.5*np.cos(2*np.pi*r/4), 
            np.sin(2*np.pi*r/4)) for g, r in dfly.nodes}
edge_colors = [dfly[u][v]['color'] for u,v in dfly.edges]
nx.draw(dfly, pos_dfly, node_color='lightgreen', node_size=300,
        edge_color=edge_colors, width=2, with_labels=True)
plt.title("Dragonfly Topology\n(Blue=Intra-group, Red=Inter-group)")

plt.subplot(122)
pos_mesh = {(x,y): (x,y) for x,y in mesh.nodes}
nx.draw(mesh, pos_mesh, node_color='orange', node_size=300,
        with_labels=True, edge_color='gray')
plt.title("4x4 Mesh Topology")

plt.tight_layout()
plt.savefig('topology_comparison.png', dpi=200)
plt.show()