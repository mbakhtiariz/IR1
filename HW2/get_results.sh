echo -n > results.txt
for f in run_files/*.run
do
  model=$(echo "$f" | grep -oE '/[^/]+\.' | cut -c2- | rev | cut -c2- | rev)

  echo "MODEL: $model" >> results.txt

  # NDCG@10
  out=$(./trec_eval/trec_eval -m ndcg_cut.10 -q ap_88_89/qrel_validation $f)
  echo "$out" >> results.txt

  # MAP@1000
  out=$(./trec_eval/trec_eval -m map_cut.1000 -q ap_88_89/qrel_validation $f)
  echo "$out" >> results.txt

  # Precision@5
  out=$(./trec_eval/trec_eval -m P.5 -q ap_88_89/qrel_validation $f)
  echo "$out" >> results.txt

  # Recall@1000
  out=$(./trec_eval/trec_eval -m recall.1000 -q ap_88_89/qrel_validation $f)
  echo "$out" >> results.txt
done
