import 'package:dio/dio.dart';
import 'package:technical_test/config/constants/enviroment.dart';
import 'package:technical_test/features/auth/domain/domain.dart';
import 'package:technical_test/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDataSource{

  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.apiUrl
    )
  );
  @override
  Future<Token> checkAuthStatus(String token) async {
    try {
      await dio.get('/api/getSuppliers', options: Options(
        headers: {
          'Authorization': token
        }
      ));

      return Token(token: token);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw CustomError('Credenciales incorrectas');
      if (e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisa tu conexion a internet');
      
      throw Exception();

    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Token> login(String user, String password) async {
    try {
      final response = await dio.post('/api/login', data:{
        'user': user,
        'password': password
      });

      final token = TokenMapper.tokenJsonToEntity(response.data);
      return token;

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw CustomError('Credenciales incorrectas');
      if (e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisa tu conexion a internet');
      
      throw Exception();

    } catch (e) {
      throw Exception();
    }
  }

}