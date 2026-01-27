select 
       rap.[SORT_ORDER]
      ,rap.[RAP_NAME]
      ,rap.[RAP_NAME_INDENT]
      ,rap.[INDENT_LEVELS]
      ,rap.[DATE]
      ,rap.[KASSE_ID]
      ,rap.[PORTFOLIO_GROUP]
      ,rap.[NODE_NAME]
      ,rap.[NODE_NO]
      ,rap.[LEVEL_1]
      ,rap.[NODE_ID]
      ,rap.[VIEW_LENS]
      ,rap.[INVESTMENT_STRUCTURE_VERSION]
      ,rap.[PARENT_NODE_NO]
      ,rap.[BUILDING_BLOCK_ID]
      ,rap.[MODEL_PORTFOLIO_TO_BE_DECOMPOSED]
      ,rap.[VERSIONID]
      ,rap.[DETAIL_LEVEL]
      ,rap.[RESULT_IN_MONTH_PCT]
      ,rap.[RESULT_IN_QUARTER_PCT]
      ,rap.[RESULT_IN_YTD_PCT]
      ,rap.[RESULT_IN_YTD_PCT_2]
      ,rap.[BENCHMARK_USED]
      ,rap.[BM_PORTFOLIO_IN_MONTH_PCT]
      ,rap.[BM_PORTFOLIO_IN_MONTH_PCT_2]
      ,rap.[BM_PORTFOLIO_IN_QUARTER_PCT]
      ,rap.[BM_PORTFOLIO_IN_YTD_PCT]
      ,rap.[BM_PORTFOLIO_IN_YTD_PCT_2]
      ,rap.[BM3_IN_MONTH_PCT]
      ,rap.[BM2_IN_MONTH_PCT]
      ,rap.[BM1_IN_MONTH_PCT]
      ,rap.[BM3_IN_QUARTER_PCT]
      ,rap.[BM2_IN_QUARTER_PCT]
      ,rap.[BM1_IN_QUARTER_PCT]
      ,rap.[BM3_IN_YTD_PCT]
      ,rap.[BM2_IN_YTD_PCT]
      ,rap.[BM1_IN_YTD_PCT]
      ,rap.[PERF_PORTFOLIO_IN_MONTH_PCT]
      ,rap.[PERF_PORTFOLIO_IN_MONTH_PCT_2]
      ,rap.[PERF_PORTFOLIO_IN_QUARTER_PCT]
      ,rap.[PERF_PORTFOLIO_IN_YTD_PCT]
      ,rap.[PERF_PORTFOLIO_IN_YTD_PCT_2]
      ,rap.[BM_PORTFOLIO_IN_MONTH_DKK]
      ,rap.[BM_PORTFOLIO_IN_MONTH_DKK_2]
      ,rap.[BM_PORTFOLIO_IN_YTD_DKK]
      ,rap.[BM_PORTFOLIO_IN_YTD_DKK_2]
      ,rap.[PERF_PORTFOLIO_IN_MONTH_DKK]
      ,rap.[PERF_PORTFOLIO_IN_MONTH_DKK_2]
      ,rap.[PERF_PORTFOLIO_IN_YTD_DKK]
      ,rap.[PERF_PORTFOLIO_IN_YTD_DKK_2]
      ,rap.[RESULT_IN_MONTH_DKK]
      ,rap.[RESULT_IN_MONTH_DKK_2]
      ,rap.[RESULT_IN_MONTH_DKK_DECOMPOSED_NODE_ID]
      ,rap.[RESULT_IN_MONTH_DKK_DECOMPOSED]
      ,rap.[RESULT_IN_MONTH_DKK_DECOMPOSED_2]
      ,rap.[RESULT_IN_QUARTER_DKK]
      ,rap.[RESULT_IN_QUARTER_DKK_DECOMPOSED_NODE_ID]
      ,rap.[RESULT_IN_QUARTER_DKK_DECOMPOSED]
      ,rap.[RESULT_IN_YTD_DKK]
      ,rap.[RESULT_IN_YTD_DKK_2]
      ,rap.[RESULT_IN_YTD_DKK_DECOMPOSED_NODE_ID]
      ,rap.[RESULT_IN_YTD_DKK_DECOMPOSED]
      ,rap.[RESULT_IN_YTD_DKK_DECOMPOSED_2]
      ,rap.[MV_IN_YTD_DKK]
      ,rap.[MV_IN_YTD_DKK_DECOMPOSED_NODE_ID]
      ,rap.[MV_IN_YTD_DKK_DECOMPOSED]
      ,rap.[EXPOSURE_IN_YTD_DKK]
      ,rap.[RISK_BASED_STRATEGIC_ACTUAL_YTD_DKK]
      ,rap.[RISK_BASED_STRATEGIC_BM_YTD_DKK]
      ,rap.[RISK_BASED_STRATEGIC_PERF_YTD_DKK]
	  ,rap.[RISK_STRESS]
	  ,rap.[RISK_BASED_STRATEGIC_ACTUAL_PCT]
      ,rap.[RISK_BASED_STRATEGIC_BM_PCT]
      ,rap.[file_name]
      ,rap.[file_path]
      ,rap.[file_modifieddate]
      ,rap.[file_source]
      ,rap.[LEVEL0]
      ,rap.[LEVEL1_SORTNO]
      ,rap.[LEVEL1]
      ,rap.[LEVEL2]
      ,rap.[LEVEL3]
	 ,coalesce(md_portfolio.SEMI_LIKVIDE,0) as SEMI_LIKVIDE
from [dbo].L0001_PERFORMANCE_CALC_RAP_V_LATEST rap

inner join  [MO].[dbo].[L0001_PERFORMANCE_CALC_REPORTS_CALENDAR] calendar
	on 1=1
	and rap.[DATE]=calendar.[DATE]
	and rap.[INVESTMENT_STRUCTURE_VERSION]=calendar.[INVESTMENT_STRUCTURE_VERSION]

left join [dbo].[L0000_MD_PERFORMANCE_NODE] md_perf_node 
	on 1=1
	and md_perf_node.[NODE_ID]= rap.[NODE_ID] 
	and md_perf_node.[INVESTMENT_STRUCTURE_VERSION]=rap.[INVESTMENT_STRUCTURE_VERSION]
	and Convert(CHAR(8),rap.[DATE],112) between md_perf_node.[DATO_FRA] and md_perf_node.[DATO_TIL]

left join [MO].[dbo].[L0000_MD_MODEL_PORTFOLIO] md_portfolio
	on 1=1
	and md_portfolio.[MODELPORTEFOLJE_ID]=rap.LEVEL_1 
	and Convert(CHAR(8),rap.[DATE],112) between  md_portfolio.[DATO_FRA] and md_portfolio.[DATO_TIL]

where 1=1
    and rap.[RAP_NAME] is not null
	and rap.[VIEW_LENS]='RC'
	and rap.[DETAIL_LEVEL]='Agg'      ---AGG eller Kasser
	and rap.[DATE]='2024-03-31'
	--and rap.LEVEL_1 in ('PKAWRLDTRS','PKAGLSC','PKASTEM','PKAFUTMVOL','TRSOSMOSIS')

--and rap.[LEVEL_1]='AFDA'
--and rap.[INDENT_LEVELS] in (1,2)

order by sort_order ,KASSE_ID