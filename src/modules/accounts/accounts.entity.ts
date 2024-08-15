export type AccountProps = {
  id: string;
  name: string;
  email: string;
  password: string;
  createdAt?: string;
  updatedAt?: string;
  userProfile?: string;
  userPhoneNumber?: string;
};

export class AccountEntity {
  constructor(private readonly props: AccountProps) {}

  toJson() {
    return {
      ...this.props,
    };
  }

  get id() {
    return this.props.id;
  }

  set name(name: string) {
    this.props.name = name;
  }

  set email(email: string) {
    this.props.email = email;
  }

  set password(password: string) {
    this.props.password = password;
  }

  set userProfile(userProfile: string) {
    this.props.userProfile = userProfile;
  }

  set userPhoneNumber(userPhoneNumber: string) {
    this.props.userPhoneNumber = userPhoneNumber;
  }
}
