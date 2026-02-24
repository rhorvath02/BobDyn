# derived.py

def apply_derived_signals(df, derived_cfg):

    for name, spec in derived_cfg.items():

        expr = spec["expression"]

        df[name] = df.eval(expr)

    return df