# Takes a generic classifier, training features (whole training data frame), training labels,
# number of folds K, and a loss function. Outputs the K-fold CV loss on the training set.

CVgeneric = function(classifier, train_features, train_labels, K, lossfn) {
  set.seed(1234)
  all_names = colnames(train_features)
  feature_names = all_names[all_names!="expert_label"]
  folds <- createFolds(train_labels, k = K)
  
  # classification accuracy
  cvAcc = rep(NA, K)
  
  for (i in 1:K) {
    fold_ind = folds[[i]]
    traindat = train_features[-fold_ind,]
    traindat_actual = train_labels[-fold_ind]
    valdat = train_features[fold_ind,]
    valdat_actual = train_labels[fold_ind]
    
    form = paste(c("expert_label ~ ", paste(feature_names, collapse = " + ")), collapse = "")
    pred_class = rep(0, nrow(valdat))
    
    if (classifier == "logistic regression") {
      mod = glm(formula = form,  data = traindat, family = "binomial")
      pred_prob = predict(mod, valdat, type = "response")
      pred_class[pred_prob > 0.5] = 1
    } else if (classifier == "lda") {
      mod = lda(expert_label ~ NDAI + SD + CORR + DF + CF + BF + AF + AN, data = traindat)
      pred_class = predict(mod, valdat)$class
    } else if (classifier == "qda") {
      mod = qda(expert_label ~ NDAI + SD + CORR + DF + CF + BF + AF + AN, data = traindat)
      pred_class = predict(mod, valdat)$class
    } else if (classifier == "knn") {
      pred_class = knn(train = traindat[,feature_names], test = valdat[,feature_names], cl = traindat_actual, k = 11)
    }
    val_acc = lossfn(valdat_actual, pred_class)
    cvAcc[i] = val_acc
  }
  
  cvAcc = round(cvAcc * 100, 2)
  tableAcc = data.frame("Folds" = 1:K, "Accuracy" = sapply(cvAcc, function(x) {paste(x,"%", sep = "")}))
  print(tableAcc)
  print(paste("Overall Accuracy: ", round(mean(cvAcc), 2), "%", sep = ""))
  
  # outputs the K-fold CV loss
  Kfold_error = round(100 - mean(cvAcc), 2)
  return(paste("K-fold CV loss: ", Kfold_error, "%", sep = ""))
}