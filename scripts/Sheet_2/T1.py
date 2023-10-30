import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit

f = lambda w: 1- w
g = lambda w, R0: np.exp(-R0*w)

w = np.linspace(0,1,1000)

fig, ax = plt.subplots()
ax.set(xlabel = "w", ylabel="f(.) and g(.)")
ax.plot(w,f(w))
ax.plot(w,g(w,2))

plt.show()