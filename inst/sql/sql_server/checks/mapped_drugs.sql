-- top 25 mapped devices

SELECT *
FROM (
	select ROW_NUMBER() OVER(ORDER BY count_big(drug_exposure_id) DESC) AS ROW_NUM,
       Cr.concept_name as "Concept Name",
       ceiling(count_big(drug_exposure_id)/100)*100 as "#Records",
       ceiling(count_big(distinct person_id)/100)*100 as "#Subjects"
       from @cdmDatabaseSchema.drug_exposure C
JOIN @vocabDatabaseSchema.CONCEPT CR
ON C.drug_concept_id = CR.CONCEPT_ID
where c. drug_concept_id != 0
group by CR.concept_name
having count_big(drug_exposure_id)>10
) z
WHERE z.ROW_NUM <= 25
ORDER BY z.ROW_NUM
