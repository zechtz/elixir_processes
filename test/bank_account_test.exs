defmodule BankAccountTest do
  use ExUnit.Case
  doctest BankAccount

  test "starts off with a balance of 0" do
    account = spawn_link(BankAccount, :start, [])
    send(account, {:check_balance, self})
    verify_balance_is 0, account 
  end 

  test "has ammount increased by the amount deposited" do
    account = spawn_link(BankAccount, :start, [])
    send(account, {:deposit, 10})
    verify_balance_is 10, account 
  end 

  test "has amount decremented by the amount withdrawn" do
    account = spawn_link(BankAccount, :start, [])
    send(account, {:deposit, 20})
    send(account, {:withdraw, 10})
    verify_balance_is 10, account 
  end 

  def verify_balance_is(expected_balance, account) do
    send(account, {:check_balance, self})
    assert_receive {:balance, ^expected_balance}
  end 
end
