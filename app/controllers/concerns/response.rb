module Response
  def json_response(object, assoc, status = :ok)
    paginate json: object, include: assoc, per_page: 10, status: status
  end
end
