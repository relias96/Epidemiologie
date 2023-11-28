#%%

import matplotlib.pyplot as plt
import numpy as np

beta = lambda  alpha, c0, c1 : (c0 * alpha) / (c1 + alpha)
theta = lambda alpha, c2 : c2 / alpha

R0 = lambda alpha, c0, c1, c2 : (beta(alpha, c0, c1) * N0) / (alpha + d + theta(alpha, c2))

d= 1/60
c0=70
c1=40
c2=500
N0 = 10

alpha = np.linspace(1,500,3000)
y1 = R0(alpha, c0, c1, c2)

fig, ax = plt.subplots()
ax.plot(alpha,y1, ylabel="R0", xlabel="alpha")
plt.show()

print("alphaMax = " + str(alpha[np.argmax(y1)]))

# %% 

AlphaMax = lambda alpha, c0, c1, c2 : alpha[np.argmax(R0(alpha, c0, c1, c2))]
c2 = np.linspace(1,2000,10000)

y2 = []
for i in c2:
    y2.append(AlphaMax(alpha, c0, c1, i))

fig2, ax2 = plt.subplots()
ax2.plot(c2,y2, xlabel="c2", ylabel="alphaMax")
# %%
