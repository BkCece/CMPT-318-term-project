import pandas as pd
import matplotlib.pyplot as plt
import sys

train_data_2006 = pd.read_csv(sys.argv[1], sep = ',')
train_data_2007 = pd.read_csv(sys.argv[2], sep = ',')
train_data_2008 = pd.read_csv(sys.argv[3], sep = ',')
test_data_2009 = pd.read_csv(sys.argv[4], sep = ',')
test_data_2010 = pd.read_csv(sys.argv[5], sep = ',')




train_agg_2006 = train_data_2006.groupby(['day', 'hour', 'week'])['Global_active_power', 'Voltage', 'Global_reactive_power', 'Global_intensity'].agg(['mean', 'min', 'max']).reset_index()
train_agg_2007 = train_data_2007.groupby(['day', 'hour', 'week'])['Global_active_power', 'Voltage', 'Global_reactive_power', 'Global_intensity'].agg(['mean', 'min', 'max']).reset_index()
train_agg_2008 = train_data_2008.groupby(['day', 'hour', 'week'])['Global_active_power', 'Voltage', 'Global_reactive_power', 'Global_intensity'].agg(['mean', 'min', 'max']).reset_index()


test_agg_2009 = test_data_2009.groupby(['day', 'hour', 'week'])['Global_active_power', 'Voltage', 'Global_reactive_power', 'Global_intensity'].agg(['mean', 'min', 'max']).reset_index()
test_agg_2010 = test_data_2010.groupby(['day', 'hour', 'week'])['Global_active_power', 'Voltage', 'Global_reactive_power', 'Global_intensity'].agg(['mean', 'min', 'max']).reset_index()


plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Global_active_power']['mean'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Global_active_power']['mean'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Global_active_power']['mean'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)
plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Mean active power')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Global_active_power']['mean'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Global_active_power']['mean'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Mean active power')
plt.savefig('Mean active power.png')

plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Global_active_power']['max'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Global_active_power']['max'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Global_active_power']['max'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)
plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Max active power')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Global_active_power']['max'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Global_active_power']['max'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Max active power')
plt.savefig('Max active power.png')

plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Voltage']['mean'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Voltage']['mean'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Voltage']['mean'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)

plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Mean Voltage')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Voltage']['mean'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Voltage']['mean'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Mean Voltage')
plt.savefig('Mean Voltage.png')

plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Voltage']['max'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Voltage']['max'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Voltage']['max'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)
plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Max Voltage')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Voltage']['max'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Voltage']['max'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Max Voltage')
plt.savefig('Max Voltage.png')

plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Global_intensity']['mean'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Global_intensity']['mean'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Global_intensity']['mean'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)
plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Mean Global_intensity')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Global_intensity']['mean'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Global_intensity']['mean'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Mean Global_intensity')
plt.savefig('Mean Global_intensity.png')

plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Global_intensity']['max'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Global_intensity']['max'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Global_intensity']['max'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)
plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Max Global_intensity')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Global_intensity']['max'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Global_intensity']['max'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Max Global_intensity')
plt.savefig('Max Global_intensity.png')


plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Voltage']['min'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Voltage']['min'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Voltage']['min'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)
plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Min Voltage')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Voltage']['min'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Voltage']['min'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Min Voltage')
plt.savefig('Min Voltage.png')



plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Global_active_power']['min'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Global_active_power']['min'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Global_active_power']['min'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)
plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Min active power')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Global_active_power']['min'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Global_active_power']['min'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Min active power')
plt.savefig('Min active power.png')

plt.figure(figsize=(20, 5))
plt.subplot(1, 2, 1)
t2006 = plt.scatter(train_agg_2006['week'], train_agg_2006['Global_intensity']['min'], marker='o')
t2007 = plt.scatter(train_agg_2007['week'], train_agg_2007['Global_intensity']['min'], marker='o')
t2008 = plt.scatter(train_agg_2008['week'], train_agg_2008['Global_intensity']['min'], marker='o')
plt.legend((t2006, t2007, t2008),
           ('2006', '2007', '2008'),
           loc='upper right',
           fontsize=8)
plt.title('Original data')
plt.xlabel('week')
plt.ylabel('Min Global_intensity')
plt.subplot(1, 2, 2)
te2009 = plt.scatter(test_agg_2009['week'], test_agg_2009['Global_intensity']['min'], marker='o')
te2010 = plt.scatter(test_agg_2010['week'], test_agg_2010['Global_intensity']['min'], marker='o')
plt.legend((te2009, te2010),
           ('2009', '2010'),
           loc='upper right',
           fontsize=8)
plt.title('Test data')
plt.xlabel('week')
plt.ylabel('Min Global_intensity')
plt.savefig('Min Global_intensity.png')
