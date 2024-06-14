#!/bin/python

import pandas as pd

df = pd.read_csv("primary_table.csv")

gc_higher_bound=1
gc_lower_bound=.45
coverage_higher_bound=100
coverage_lower_bound=10
coverage_col_title="assembly.bp.p_ctg_mapped_cov"
outname="primary_subset.csv"

df = df[df["gc"].between(gc_lower_bound,gc_higher_bound)]
df = df[df[coverage_col_title].between(coverage_lower_bound,coverage_higher_bound)]
df.to_csv(outname)


