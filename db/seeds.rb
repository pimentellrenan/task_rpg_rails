user = User.find_or_create_by!(email: "renan@local.test") do |u|
  u.password = "senha123456"
  u.password_confirmation = "senha123456"
end

[
  ["Casa", "#1f7a8c"],
  ["Comprar", "#f0a202"],
  ["Vender", "#bf4342"],
  ["Semana", "#5c6f68"]
].each do |name, color|
  user.projects.find_or_create_by!(name:) { |project| project.color = color }
end

project = user.projects.find_by!(name: "Semana")
["Limpar churrasqueira", "Retirar gancho da rede", "Passar WD no armario", "Pagar Cristiano hoje 20h"].each do |title|
  user.tasks.find_or_create_by!(title:) do |task|
    parsed = QuickCaptureParser.parse(title)
    task.project = project
    task.priority = parsed[:priority]
    task.due_at = parsed[:due_at]
  end
end
