module FishABM

using DataFrames, Distributions, Gadfly, ProgressMeter

export
  # Types
  AgentAssumptions,
  EnvironmentAssumptions,
  StockAssumptions,
  StockDB,

  # Agent functions
  agentdb,
  kill!,
  localmove,
  move!,
  injectagents!,

  # Stock functions
  harvest!,
  ageadults!,

  # Agent-Stock function
  spawn!,
  graduate!,

  # Utilities
  pad_environment!,
  plot_agents,
  plot_stock,
  plot_stock_k,
  simpleWriteOut,
  writeOutAgentPlots,

  # Simulate
  simulate

include("types.jl")
include("utilities.jl")
include("agents.jl")
include("stock.jl")
include("agent_stock_interaction.jl")
include("simulate.jl")

end # module
