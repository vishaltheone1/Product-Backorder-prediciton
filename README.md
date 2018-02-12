# Product-Backorder-problem-in-the e-Commerce-industry

Training dataset - https://drive.google.com/file/d/1yMp_Fbi36jqn1F2iUayYO0K3c0iATum8/view?usp=sharing

Problem statement - To tackle the problem of maintaining stocks in supply chain management by identifying those products which were more
                     likely to get backordered so as to not lose those customers who may order product elsewhere in the meantime it takes
                     the product to reach that particular sku.

Model used - The training set being an imbalanced dataset wrt to the target variable, the method of synthetic minority oversampling
              technique was applied so that those 0.25% of products which were getting backorders can be predicted.
              
              Treebag classification model was used.
              
Result obtained - AUC of 0.87 was acheived on the test set. 
