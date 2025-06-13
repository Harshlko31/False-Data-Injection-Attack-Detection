# False Data Injection Attack Detection in CPPS

Made by
- [@Harshlko31](https://github.com/Harshlko31)
- [@Parth-kumar-1802](https://github.com/Parth-kumar-1802)
- [@Avinash29163](https://github.com/Avinash29163)


## Description 

The integration of cyber and physical components in modern electric power systems gives rise to Cyber-Physical
Power Systems (CPPS), which enable intelligent control, real-time monitoring, and increased operational
efficiency. However, this interconnection also introduces vulnerabilities to sophisticated cyber-attacks. Among
the most critical of these are False Data Injection Attacks (FDIAs), where adversaries manipulate sensor
measurements to mislead system state estimation and disrupt control decisions. These attacks often bypass
traditional detection mechanisms, posing a significant threat to the stability and reliability of power systems.
This project focuses on detecting FDIAs using machine learning techniques, which offer a flexible and data-driven
alternative to rule-based methods. It simulates normal and attack conditions on the IEEE-118 bus system using
MATPOWER to generate realistic datasets. The data incorporates measurement noise and randomized attack
patterns to reflect real-world complexities. These scenarios serve as a foundation for training and evaluating a
range of machine learning models.

This study implements both classical and deep learning models, including methods that account for the spatial
structure of the power grid. Each model is assessed based on its ability to accurately distinguish between normal
and compromised states under varying conditions. The analysis emphasizes model reliability, scalability, and
resistance to false alarms—key traits for practical deployment in critical infrastructure.
The outcome reveals that deep learning models, particularly those designed to extract spatial and temporal
features, are more effective in identifying subtle and coordinated attacks. Graph-based models further demonstrate
the advantage of incorporating topological information from the grid, enhancing detection in complex scenarios.
Semi-supervised approaches also prove valuable, enabling robust detection even when labelled data is limited.
Overall, the project underscores the potential of machine learning to enhance the cybersecurity of CPPS. It
demonstrates that intelligent, adaptive detection systems can outperform traditional methods by learning from
data rather than relying on static rules. The findings support a shift toward real-time, scalable, and topology-aware
solutions that strengthen the resilience of modern power systems against evolving threats.



## Methodology

![Flow Chart](/assets/flowchart.png)


<!-- 
The repository holds the code and data for the project work "False Data Injection Attack Detection on Cyber Physical Power System using Machine Learning Methods" done under the guidance of Professor Kalyan Chatterjee in the Department of Electrical Engineering In IIT(ISM) Dhanbad.
<br>Following is the description of the files in the repository:-</br>
<br>Admittance Matrix:- CSV File holding the information about a standard IEEE 118 bus system. </br>
<br>FDIA_Detection_Using_Semi_Supervised:- Code for Semi-Supervised Learning Algorithms for FDIA detection.</br>
<br>FDIA_Detection_Using_CNN:- Code for a convolutional Neural Network to detect FDIA.</br>
<br>FDIA_Detection_Using_GNN:- Code for a data handling and design of a Graph Neural Network for FDIA detection.</br>
<br> The Data files can be accessed using the following link :- https://drive.google.com/drive/u/0/folders/12pc99Plh8tXQaRXOMN05joU9AZomr082 </br> -->
