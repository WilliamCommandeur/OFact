rm /micrations.sqitch.plan

sqitch init ofact --engine pg --top-dir migrations

sqitch add 1.init -n 'création des tables'
sqitch add 2.3fn -n 'calcul du taux de tva'
sqitch add 3.crud_functions -n 'insert et update des données'
sqitch add 4.invoice_details -n "ajout d'une vue détaillée des factures"
sqitch add 5.invoice_recap -n "ajout d'une vue récapitulative des factures"
sqitch add 6.sales -n "ajout d'une fonction pour récupérer les ventes sur un intervalle"
sqitch add 7.packed_invoice -n "ajout de la fonction packed_invoice"
sqitch add 8.add_invoice -n "ajout d'une facture en BDD"