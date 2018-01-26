for f in results/*.run
do
  model=$(echo "$f" | grep -oE '/[^/]+\.' | cut -c2- | rev | cut -c2- | rev)

  echo $model >> stats.txt

  measure="NDCG@10"
  out=$(./trec_eval/trec_eval -m ndcg_cut.10 ap_88_89/qrel_validation $f)
  echo $'\t'"$measure: ${out: -5}" >> stats.txt

  measure="MAP@1000"
  out=$(./trec_eval/trec_eval -m map_cut.1000 ap_88_89/qrel_validation $f)
  echo $'\t'"$measure: ${out: -5}" >> stats.txt

  measure="Precision@5"
  out=$(./trec_eval/trec_eval -m P.5 ap_88_89/qrel_validation $f)
  echo $'\t'"$measure: ${out: -5}" >> stats.txt

  measure="Recall@1000"
  out=$(./trec_eval/trec_eval -m recall.1000 ap_88_89/qrel_validation $f)
  echo $'\t'"$measure: ${out: -5}" >> stats.txt
done
