defmodule BankAccount do
  def start do
    await([]) 
  end 

  def await(events) do
    receive do
      {:check_balance, pid} -> divulge_balance(pid, events)
      {:deposit, amount}    -> events = deposit(amount, events) 
    end 
    await(events) 
  end 

  defp divulge_balance(pid, events) do
    send(pid, {:balance, calculate_balance(events)})
  end 

  defp deposit(amount, events) do
    events ++ [{:deposit, amount}]
  end 

  defp calculate_balance(events) do
    deposits = sum(events)
    deposits 
  end 

  defp sum(events) do
    Enum.reduce(events, 0, fn{_, amount}, acc -> acc + amount end)
  end 
end
