rm /micrations.sqitch.plan

sqitch init ofact --engine pg --top-dir migrations

sqitch add 1.init -n 'création des tables'
sqitch add 2.3fn -n 'calcul du taux de tva'