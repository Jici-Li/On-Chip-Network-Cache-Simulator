import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

def nuca_latency(req, mem):
    if req == mem:
        return 10
    elif req // 4 == mem // 4:
        return 25
    else:
        return 50

matrix = np.zeros((8,8), dtype=int)
for i in range(8):
    for j in range(8):
        matrix[i,j] = nuca_latency(i,j)

plt.figure(figsize=(10,8))
ax = sns.heatmap(
    matrix,
    annot=True,
    fmt="d",  
    cmap="RdYlGn_r",
    vmin=0,
    vmax=60,
    linewidths=0.5,
    annot_kws={"size":10}
)
ax.set_title("NUCA(ns)", fontsize=14)
ax.set_xlabel("require", fontsize=12)
ax.set_ylabel("require", fontsize=12)
plt.tight_layout()
plt.savefig("nuca_heatmap_pro.png", dpi=300)
plt.show()