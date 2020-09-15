function temp_obj_eval = perf(u0, u0_GT)

u=(u0);

[xm ym] = size(u);

% TP pixels
temp_tp = [u == 0] & [u0_GT == 0];

% FP pixels
temp_fp = [u == 0] & [u0_GT ~= 0];

% FN pixels
temp_fn = [u ~= 0] & [u0_GT == 0];

% TN pixels 
temp_tn = [u ~= 0] & [u0_GT ~= 0];

count_tp = sum(sum(temp_tp));
count_fp = sum(sum(temp_fp));
count_fn = sum(sum(temp_fn));
count_tn = sum(sum(temp_tn));

% sensetivity
temp_sens = count_tp / (count_tp + count_fn);

% specificity
temp_spec = count_tn / (count_tn + count_fp);

% Accuracy: mean of sensetivity and specificity

temp_accu = ((count_tp + count_tn) / (count_tp + count_tn + count_fp + count_fn));

% Error Rate

temp_obj_eval.Accuracy = temp_accu;
temp_obj_eval.Sensitivity = temp_sens;
temp_obj_eval.Specificity = temp_spec;

end