defmodule ElixirTwitter.MessageController do
  use ElixirTwitter.Web, :controller

  alias ElixirTwitter.Message

  plug :scrub_params, "message" when action in [:create, :update]

  def index(conn, _params) do
    messages = Repo.all(Message)
    render(conn, "index.html", messages: messages)
  end

  def new(conn, _params) do
    changeset = Message.changeset(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    changeset = Message.changeset(%Message{}, message_params)

    case Repo.insert(changeset) do
      {:ok, _message} ->
        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: message_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)
    user = Repo.get!(ElixirTwitter.User, message.user_id)
    render(conn, "show.html", message: message, user: user)
  end

  def edit(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)
    changeset = Message.changeset(message)
    render(conn, "edit.html", message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Repo.get!(Message, id)
    changeset = Message.changeset(message, message_params)

    case Repo.update(changeset) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message updated successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, changeset} ->
        render(conn, "edit.html", message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: message_path(conn, :index))
  end
end
