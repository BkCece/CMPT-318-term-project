import pandas as pd
import matplotlib.pyplot as plt
import sys

train_data = pd.read_csv(sys.argv[1], sep = ',')
test_data = pd.read_csv(sys.argv[2], sep = ',')

train_agg = train_data.groupby(['day', 'hour', 'week'])['Global_active_power', 'Voltage', 'Global_reactive_power', 'Global_intensity'].agg(['mean', 'min', 'max']).reset_index()

train_agg = train_agg.sort_values(by = ['week'])
test_agg = test_data.groupby(['day', 'hour', 'week'])['Global_active_power', 'Voltage', 'Global_reactive_power', 'Global_intensity'].agg(['mean', 'min', 'max']).reset_index()

test_agg = test_agg.sort_values(by = ['week'])

plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
plt.scatter(train_agg['week'], train_agg['Global_active_power']['mean'], marker='o')
plt.subplot(1, 2, 2)
plt.scatter(test_agg['week'], test_agg['Global_active_power']['mean'], marker='o')
plt.show()
